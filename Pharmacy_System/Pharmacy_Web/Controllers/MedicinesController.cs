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
    public class MedicinesController : Controller
    {

        private readonly string baseApi = "https://localhost:44383/api";

        // GET: Medicines
        public async Task<IActionResult> Index()
        {
            List<Medicine> medicines = new List<Medicine>();

            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync($"{baseApi}/Medicines"))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        var content = await response.Content.ReadAsStringAsync();
                        medicines = JsonConvert.DeserializeObject<List<Medicine>>(content);
                    }
                }
            }

            var viewModel = medicines.Select(x => new MedicineDetails
            {
                Id = x.Id,
                Name = x.Name,
                ShortDescription = x.Description.Length > 30? x.Description.Substring(0,30) + "....": x.Description,
                FullDescription = x.Description,
                Company = x.Company,
                MadeIn = x.MadeIn,
                Price = x.Price,
                DateCreated = x.DateCreated,
                ExpirationDate = x.ExpirationDate,
                CategoryId = x.CategoryId,
                Category = x.Category,
                ImageUrl = $"https://localhost:44383/Images/{x.ImageUrl}"
            }
            ).ToList();
            return View(viewModel);
        }

        // GET: Medicines/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Medicine medicine = new Medicine();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync($"{baseApi}/Medicines/" + id))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        var content = await response.Content.ReadAsStringAsync();
                        medicine = JsonConvert.DeserializeObject<Medicine>(content);

                        
                        return View(medicine);
                    }

                    return NotFound();
                }
            }
        }

        // GET: Medicines/Create
        public async Task<IActionResult> Create()
        {
            await LoadCategoriesSelectList();
            return View();
        }

        // POST: Medicines/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(CreateMedicineDto medicineDto)
        {

           
            using (var content = new MultipartFormDataContent())
            {
                //content.Add(new StringContent(medicineDto.Id.ToString()), "Id");
                content.Add(new StringContent(medicineDto.Name.ToString()), "Name");
                content.Add(new StringContent(medicineDto.Description.ToString()), "Description");
                content.Add(new StringContent(medicineDto.Company.ToString()), "Company");
                content.Add(new StringContent(medicineDto.MadeIn.ToString()), "MadeIn");
                content.Add(new StringContent(medicineDto.Price.ToString()), "Price");
                content.Add(new StringContent(medicineDto.DateCreated.ToString()), "DateCreated");
                content.Add(new StringContent(medicineDto.ExpirationDate.ToString()), "ExpirationDate");
                content.Add(new StringContent(medicineDto.CategoryId.ToString()), "CategoryId");
                
                if ( medicineDto.ImageFile != null && medicineDto.ImageFile.Length> 0)
                {
                    var img = new StreamContent(medicineDto.ImageFile.OpenReadStream());
                    img.Headers.ContentType = new MediaTypeHeaderValue(medicineDto.ImageFile.ContentType);
                    content.Add(img, "ImageFile", medicineDto.ImageFile.FileName);
                }


                if (medicineDto == null)
                {
                    return NotFound();
                }
                
                
                using (var httpClient = new HttpClient())
                {
                    /*var json = JsonConvert.SerializeObject(content);
                    var contents = new StringContent(json, Encoding.UTF8, "application/json");
                    */using (var response = await httpClient.PostAsync($"{baseApi}/Medicines", content))
                    {
                        if (response.IsSuccessStatusCode)
                        {
                            return RedirectToAction(nameof(Index));
                        }
                    }
                }

                await LoadCategoriesSelectList(medicineDto.CategoryId);
                return View(medicineDto);

            }



            }

        // GET: Medicines/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Medicine medicine = new Medicine();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync($"{baseApi}/Medicines/" + id))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        var content = await response.Content.ReadAsStringAsync();
                        medicine = JsonConvert.DeserializeObject<Medicine>(content);
                    }
                }
            }

            var medicineDto = new CreateMedicineDto
            {
                Id = medicine.Id,
                Name = medicine.Name,
                Description = medicine.Description,
                Company = medicine.Company,
                MadeIn = medicine.MadeIn,
                Price = medicine.Price,
                DateCreated = medicine.DateCreated,
                ExpirationDate = medicine.ExpirationDate,
                CategoryId = medicine.CategoryId,
                //Category = medicineDto.Category,
            };
            await LoadCategoriesSelectList(medicine?.CategoryId);
            return View(medicineDto);
        }

        // POST: Medicines/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(CreateMedicineDto medicineDto)
        {
            using (var content = new MultipartFormDataContent())
            {
                content.Add(new StringContent(medicineDto.Id.ToString()), "Id");
                content.Add(new StringContent(medicineDto.Name.ToString()), "Name");
                content.Add(new StringContent(medicineDto.Description.ToString()), "Description");
                content.Add(new StringContent(medicineDto.Company.ToString()), "Company");
                content.Add(new StringContent(medicineDto.MadeIn.ToString()), "MadeIn");
                content.Add(new StringContent(medicineDto.Price.ToString()), "Price");
                content.Add(new StringContent(medicineDto.DateCreated.ToString()), "DateCreated");
                content.Add(new StringContent(medicineDto.ExpirationDate.ToString()), "ExpirationDate");
                content.Add(new StringContent(medicineDto.CategoryId.ToString()), "CategoryId");

                if (medicineDto.ImageFile != null && medicineDto.ImageFile.Length > 0)
                {
                    var img = new StreamContent(medicineDto.ImageFile.OpenReadStream());
                    img.Headers.ContentType = new MediaTypeHeaderValue(medicineDto.ImageFile.ContentType);
                    content.Add(img, "ImageFile", medicineDto.ImageFile.FileName);
                }


                if (medicineDto == null)
                {
                    return NotFound();
                }


                using (var httpClient = new HttpClient())
                {
                    /*var json = JsonConvert.SerializeObject(content);
                    var contents = new StringContent(json, Encoding.UTF8, "application/json");
                    */
                    using (var response = await httpClient.PutAsync($"{baseApi}/Medicines/" + medicineDto.Id, content))
                    {
                        if (response.IsSuccessStatusCode)
                        {
                            return RedirectToAction(nameof(Index));
                        }
                    }
                }
            }
                await LoadCategoriesSelectList(medicineDto.CategoryId);
                return View(medicineDto);



            }

            // GET: Medicines/Delete/5
            public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Medicine medicine = new Medicine();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync($"{baseApi}/Medicines/" + id))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        var content = await response.Content.ReadAsStringAsync();
                        medicine = JsonConvert.DeserializeObject<Medicine>(content);
                    }
                }
            }

            return View(medicine);
        }

        // POST: Medicines/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.DeleteAsync($"{baseApi}/Medicines/" + id))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        return RedirectToAction(nameof(Index));
                    }
                    return BadRequest("Faild Delete,try again");
                }
            }
        }


        private async Task LoadCategoriesSelectList(int? selectedCategoryId = null)
        {
            using (var httpClient = new HttpClient())
            {
                var response = await httpClient.GetAsync($"{baseApi}/Categories");
                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    var categories = JsonConvert.DeserializeObject<List<Category>>(content);

                    ViewData["CategoryId"] = new SelectList(categories, "Id", "Name", selectedCategoryId);

                }
                else
                {
                    ViewData["CategoryId"] = new SelectList(Enumerable.Empty<Category>(), "Id", "Name", selectedCategoryId);
                }
            }
        }


    }
}







/*
var form = new MultipartFormDataContent();

form.Add(new StringContent(addMedicine.Name), "Name");
form.Add(new StringContent(addMedicine.Description), "Description");
form.Add(new StringContent(addMedicine.Company), "Company");
form.Add(new StringContent(addMedicine.MadeIn), "MadeIn");
form.Add(new StringContent(addMedicine.Price.ToString()), "Price");
form.Add(new StringContent(addMedicine.DateCreated.ToString()), "DateCreated");
form.Add(new StringContent(addMedicine.ExpirationDate.ToString()), "ExpirationDate");
form.Add(new StringContent(addMedicine.CategoryId.ToString()), "CategoryId");

var streamContent = new StreamContent(addMedicine.Image.OpenReadStream());
streamContent.Headers.ContentType = new MediaTypeHeaderValue(addMedicine.Image.ContentType);
form.Add(streamContent, "Image", addMedicine.Image.FileName);

var medicine = new Medicine
{
    Id = addMedicine.Id,
    Name = addMedicine.Name,
    Description = addMedicine.Description,
    Company = addMedicine.Company,
    MadeIn = addMedicine.MadeIn,
    Price = addMedicine.Price,
    DateCreated = addMedicine.DateCreated,
    ExpirationDate = addMedicine.ExpirationDate,
    Category = addMedicine.Category,
    ImageUrl = fileName
};
*/