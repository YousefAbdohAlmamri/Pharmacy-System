using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Pharmacy_Web.Models;
using Pharmacy_Web.ViewModels;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;


namespace Pharmacy_Web.Controllers
{
    public class HomeController : Controller
    {
        private readonly string baseApi = "https://localhost:44383/api";
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

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
            
        }

        public async Task<IActionResult> Privacy(int? id)
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
        
        public async Task<IActionResult> Search(string name)
        {
            if (string.IsNullOrWhiteSpace(name))
            {
                return View(new List<Pharmacy>());
            }

            List<Pharmacy> pharmacies = new List<Pharmacy>();

            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync($"{baseApi}/Pharmacies/search/{name}"))
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
                ImageUrl = $"https://localhost:44383/Images/{x.ImageUrl}"
            }
            ).ToList();

            return View(viewModel);

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

            //pharmacyDto.ImageUrl = fileName;

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
        }




        // GET: Medicines/Details/5
        public async Task<IActionResult> MedicineDetails(int? id)
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


        private async Task LoadUsersSelectList(int? selectedUserId = null)
        {
            using (var httpClient = new HttpClient())
            {
                var response = await httpClient.GetAsync($"{baseApi}/Users");
                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    var users = JsonConvert.DeserializeObject<List<User>>(content);

                    ViewData["UserId"] = new SelectList(users, "Id", "Name", selectedUserId);

                }
                else
                {
                    ViewData["UserId"] = new SelectList(Enumerable.Empty<User>(), "Id", "Name", selectedUserId);
                }
            }
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
