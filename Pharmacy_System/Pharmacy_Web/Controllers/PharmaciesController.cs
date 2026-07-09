using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Pharmacy_Web.Models;
using Pharmacy_Web.ViewModels;

namespace Pharmacy_Web.Controllers
{
    
    public class PharmaciesController : Controller
    {

        private readonly string baseApi = "https://localhost:44383/api";
        // GET: Pharmacies
        public async Task<IActionResult> Index()
        {
            List<Pharmacy> pharmacies = new List<Pharmacy>();

            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync($"{baseApi}/Pharmacies"))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        var content = await response.Content.ReadAsStringAsync();
                        pharmacies = JsonConvert.DeserializeObject<List<Pharmacy>>(content);
                    }
                }
            }


            var viewModel = pharmacies.Select(x => new Pharmacy
            {
                Id = x.Id,
                Name = x.Name,
                Description = x.Description,
                Location = x.Location,
                Phone = x.Phone,
                User = x.User,
                PharmacyMedicines = x.PharmacyMedicines,
                ImageUrl = $"https://localhost:44383/Images/{x.ImageUrl}"
            }
            ).ToList();

            return View(viewModel);



            /*
            var viewModel = pharmacies.Select(x => new PharmacyDetailsDto
                {
                Id = x.Id,
                Name = x.Name,
                Description = x.Description,
                ImageUrl = $"https://localhost:44383/Images/{x.ImageUrl}",
                Location = x.Location,
                Phone = x.Phone,
                User = x.User,
                Medicines = x.PharmacyMedicines.Select(pm => new PharmacyMedicineViewDto
                {
                    MedicineId = pm.MedicineId,
                    Name = pm.Medicine.Name,
                    CategoryId = pm.Medicine.CategoryId,
                    Stock = pm.Stock
                }
                    ).ToList()

                }
                ).ToList();
    */
           
        }

        // GET: Pharmacies/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Pharmacy pharmacy = new Pharmacy();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync($"{baseApi}/Pharmacies/" + id))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        var content = await response.Content.ReadAsStringAsync();
                        pharmacy = JsonConvert.DeserializeObject<Pharmacy>(content);

                        return View(pharmacy);
                    }

                    return NotFound();
                }
            }

        }

        // GET: Pharmacies/Create
        public async Task<IActionResult> Create()
        {

            List<Medicine> medicines = new List<Medicine>();
            using (var httpClient = new HttpClient())
            {
                var response = await httpClient.GetAsync($"{baseApi}/Medicines");
                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    medicines = JsonConvert.DeserializeObject<List<Medicine>>(content);
                }
                
            }

            ViewBag.Medicines = medicines;
            await LoadUsersSelectList();
            return View();
        }

        // POST: Pharmacies/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(CreatePharmacyDto pharmacyDto)
        {

            using (var content = new MultipartFormDataContent())
            {
                //content.Add(new StringContent(pharmacyDto.Id.ToString()), "Id");
                content.Add(new StringContent(pharmacyDto.Name.ToString()), "Name");
                content.Add(new StringContent(pharmacyDto.Description.ToString()), "Description");
                content.Add(new StringContent(pharmacyDto.Location.ToString()), "Location");
                content.Add(new StringContent(pharmacyDto.Phone.ToString()), "Phone");
                content.Add(new StringContent(pharmacyDto.UserId.ToString()), "UserId");

                if (pharmacyDto.ImageFile != null && pharmacyDto.ImageFile.Length > 0)
                {
                    var img = new StreamContent(pharmacyDto.ImageFile.OpenReadStream());
                    img.Headers.ContentType = new MediaTypeHeaderValue(pharmacyDto.ImageFile.ContentType);
                    content.Add(img, "ImageFile", pharmacyDto.ImageFile.FileName);
                }

                content.Add(new StringContent(pharmacyDto.Medicines ?? "[]", Encoding.UTF8, "application/json"), "Medicines");

                if (pharmacyDto == null)
                {
                    return NotFound();
                }


                using (var httpClient = new HttpClient())
                {
                    /*var json = JsonConvert.SerializeObject(content);
                    var contents = new StringContent(json, Encoding.UTF8, "application/json");
                    */
                    using (var response = await httpClient.PostAsync($"{baseApi}/Pharmacies", content))
                    {
                        if (response.IsSuccessStatusCode)
                        {
                            return RedirectToAction(nameof(Index));
                        }
                    }
                }



                List<Medicine> medicines = new List<Medicine>();
                using (var httpClient = new HttpClient())
                {
                    var response = await httpClient.GetAsync($"{baseApi}/Medicines");
                    if (response.IsSuccessStatusCode)
                    {
                        var contents = await response.Content.ReadAsStringAsync();
                        medicines = JsonConvert.DeserializeObject<List<Medicine>>(contents);
                    }

                }

                ViewBag.Medicines = medicines;

                await LoadUsersSelectList(pharmacyDto.UserId);
                return View(pharmacyDto);

            }
            /*
            pharmacyDto.ImageUrl = fileName;

            if (ModelState.IsValid)
            {
                using (var httpClient = new HttpClient())
                {
                    var json = JsonConvert.SerializeObject(pharmacyDto);
                    var content = new StringContent(json, Encoding.UTF8, "application/json");
                    using (var response = await httpClient.PostAsync($"{baseApi}/Pharmacies/", content))
                    {
                        if (response.IsSuccessStatusCode)
                        {
                            return RedirectToAction(nameof(Index));
                        }

                        ModelState.AddModelError(string.Empty, "حدث خطأ اثناء حفظ الصيدلية");
                    }
                }

            }
            

           
            List<Medicine> medicines = new List<Medicine>();
            using (var httpClient = new HttpClient())
            {
                var response = await httpClient.GetAsync($"{baseApi}/Medicines");
                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    medicines = JsonConvert.DeserializeObject<List<Medicine>>(content);
                }

            }

            ViewBag.Medicines = medicines;

            await LoadUsersSelectList(pharmacyDto.UserId);
            return View(pharmacyDto);

            */
        }

        // GET: Pharmacies/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {

            if (id == null)
            {
                return NotFound();
            }

            CreatePharmacyDto pharmacy = new CreatePharmacyDto();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync($"{baseApi}/Pharmacies/" + id))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        var content = await response.Content.ReadAsStringAsync();
                        pharmacy = JsonConvert.DeserializeObject<CreatePharmacyDto>(content);
                    }
                }
            }


            List<Medicine> medicines = new List<Medicine>();
            using (var httpClient = new HttpClient())
            {
                var response = await httpClient.GetAsync($"{baseApi}/Medicines");
                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    medicines = JsonConvert.DeserializeObject<List<Medicine>>(content);
                }

            }

            ViewBag.Medicines = medicines;
            await LoadUsersSelectList(pharmacy?.UserId);
            return View(pharmacy);
        }

        // POST: Pharmacies/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(CreatePharmacyDto pharmacyDto)
        {
            using (var content = new MultipartFormDataContent())
            {
                content.Add(new StringContent(pharmacyDto.Id.ToString()), "Id");
                content.Add(new StringContent(pharmacyDto.Name.ToString()), "Name");
                content.Add(new StringContent(pharmacyDto.Description.ToString()), "Description");
                content.Add(new StringContent(pharmacyDto.Location.ToString()), "Location");
                content.Add(new StringContent(pharmacyDto.Phone.ToString()), "Phone");
                content.Add(new StringContent(pharmacyDto.UserId.ToString()), "UserId");

                if (pharmacyDto.ImageFile != null && pharmacyDto.ImageFile.Length > 0)
                {
                    var img = new StreamContent(pharmacyDto.ImageFile.OpenReadStream());
                    img.Headers.ContentType = new MediaTypeHeaderValue(pharmacyDto.ImageFile.ContentType);
                    content.Add(img, "ImageFile", pharmacyDto.ImageFile.FileName);
                }

                content.Add(new StringContent(pharmacyDto.Medicines ?? "[]", Encoding.UTF8, "application/json"), "Medicines");

                if (pharmacyDto == null)
                {
                    return NotFound();
                }


                using (var httpClient = new HttpClient())
                {
                    /*var json = JsonConvert.SerializeObject(content);
                    var contents = new StringContent(json, Encoding.UTF8, "application/json");
                    */
                    using (var response = await httpClient.PutAsync($"{baseApi}/Pharmacies/"+ pharmacyDto.Id, content))
                    {
                        if (response.IsSuccessStatusCode)
                        {
                            return RedirectToAction(nameof(Index));
                        }
                    }
                }



                List<Medicine> medicines = new List<Medicine>();
                using (var httpClient = new HttpClient())
                {
                    var response = await httpClient.GetAsync($"{baseApi}/Medicines");
                    if (response.IsSuccessStatusCode)
                    {
                        var contents = await response.Content.ReadAsStringAsync();
                        medicines = JsonConvert.DeserializeObject<List<Medicine>>(contents);
                    }

                }

                ViewBag.Medicines = medicines;

                await LoadUsersSelectList(pharmacyDto.UserId);
                return View(pharmacyDto);

            }
/*
            if (pharmacyDto.ImageFile == null || pharmacyDto.ImageFile.Length == 0)
            {
                return BadRequest("ادخل الصورة");
            }

            string fileName = pharmacyDto.ImageFile.FileName;
            string myUpload = Path.Combine(@"C:\Users\YOUSEF\source\repos\Pharmacy_System\Pharmacy_API\wwwroot\Images", fileName);

            using (Stream stream = new FileStream(myUpload, FileMode.Create))
            {
                await pharmacyDto.ImageFile.CopyToAsync(stream);
            }

            //pharmacyDto.ImageUrl = fileName;

            if (pharmacyDto == null)
            {
                return NotFound();
            }


            if (ModelState.IsValid)
            {
                using (var httpClient = new HttpClient())
                {
                    StringContent stringContent = new StringContent(JsonConvert.SerializeObject(pharmacyDto), Encoding.UTF8, "application/json");
                    using (var response = await httpClient.PutAsync($"{baseApi}/Pharmacies/" + pharmacyDto.Id, stringContent))
                    {
                        if (response.IsSuccessStatusCode)
                        {
                            return RedirectToAction(nameof(Index));
                        }
                        ModelState.AddModelError(string.Empty, "حدث خطأ اثناء حفظ الصيدلية");

                    }
                }
            }

                

            List<Medicine> medicines = new List<Medicine>();
            using (var httpClient = new HttpClient())
            {
                var response = await httpClient.GetAsync($"{baseApi}/Medicines");
                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    medicines = JsonConvert.DeserializeObject<List<Medicine>>(content);
                }

            }

            ViewBag.Medicines = medicines;
            await LoadUsersSelectList(pharmacyDto.UserId);
            //await LoadMedicinesSelectList(pharmacy.PharmacyMedicines.);

            
            return View(pharmacyDto);*/
        }

        // GET: Pharmacies/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Pharmacy pharmacy = new Pharmacy();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync($"{baseApi}/Pharmacies/" + id))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        var content = await response.Content.ReadAsStringAsync();
                        pharmacy = JsonConvert.DeserializeObject<Pharmacy>(content);
                    }
                }
            }

            return View(pharmacy);
        }

        // POST: Pharmacies/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.DeleteAsync($"{baseApi}/Pharmacies/" + id))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        return RedirectToAction(nameof(Index));
                    }
                    return BadRequest("Faild Delete,try again");
                }
            }
        }


        public async Task LoadUsersSelectList(int? selectedUserId = null)
        {
            using (var httpClient = new HttpClient())
            {
                var response = await httpClient.GetAsync($"{baseApi}/Users");
                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    var users = JsonConvert.DeserializeObject<List<User>>(content);

                    ViewData["UserId"] = new SelectList(users, "Id", "Name",selectedUserId);

                }
                else
                {
                    ViewData["UserId"] = new SelectList(Enumerable.Empty<User>(), "Id", "Name",selectedUserId);
                }
            }
        }
        
        /*[HttpGet]
        private async Task LoadMedicinesSelectList(int? selectedUserId = null)
        {
            using (var httpClient = new HttpClient())
            {
                var response = await httpClient.GetAsync($"{baseApi}/Medicines");
                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    var medicines = JsonConvert.DeserializeObject<List<Medicine>>(content);

                    ViewData["MedicineId"] = new SelectList(medicines, "Id", "Name", selectedUserId);
                }
                else
                {
                    ViewData["MedicineId"] = new SelectList(Enumerable.Empty<Medicine>(), "Id", "Name", selectedUserId);
                }
            }
            
        }*/



    }
}












/*
            if (pharmacyDto.ImageFile == null || pharmacyDto.ImageFile.Length == 0)
            {
                return BadRequest("ادخل الصورة");
            }

            string fileName = pharmacyDto.ImageFile.FileName;
            string myUpload = Path.Combine(@"C:\Users\YOUSEF\source\repos\Pharmacy_System\Pharmacy_API\wwwroot\Images", fileName);

            using (Stream stream = new FileStream(myUpload, FileMode.Create))
            {
                await pharmacyDto.ImageFile.CopyToAsync(stream);
            }

            /*var pharmacyDtos = new CreatePharmacyDto
            { 
                Id = pharmacyDto.Id,
                Name = pharmacyDto.Name,
                Description = pharmacyDto.Description,
                Location = pharmacyDto.Location,
                Phone = pharmacyDto.Phone,
                UserId = pharmacyDto.UserId
            };*/
