using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Pharmacy_Web.Models;

namespace Pharmacy_Web.Controllers
{
    public class CategoriesController : Controller
    {

        // GET: Categories
        public async Task<IActionResult> Index()
        {
            List<Category> categories = new List<Category>();

            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync("https://localhost:44383/api/Categories"))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        var content = await response.Content.ReadAsStringAsync();
                        categories = JsonConvert.DeserializeObject<List<Category>>(content);
                    }
                }
            }
            return View(categories);
        }


        // GET: Categories/Details/5

        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Category category = new Category();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync("https://localhost:44383/api/Categories/" + id))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        var content = await response.Content.ReadAsStringAsync();
                        category = JsonConvert.DeserializeObject<Category>(content);

                        return View(category);
                    }

                    return NotFound();
                }
            }


        }

        // GET: Categories/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Categories/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Category category)
        {
            if (category == null)
            {
                return NotFound();
            }
            using (var httpClient = new HttpClient())
            {
                var json = JsonConvert.SerializeObject(category);
                var content = new StringContent(json, Encoding.UTF8, "application/json");
                using (var response = await httpClient.PostAsync("https://localhost:44383/api/Categories/", content))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        return RedirectToAction(nameof(Index));
                    }
                }
            }

            return View(category);
        }


        // GET: Categories/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Category category = new Category();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync("https://localhost:44383/api/Categories/" + id))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        var content = await response.Content.ReadAsStringAsync();
                        category = JsonConvert.DeserializeObject<Category>(content);
                    }
                }
            }

            return View(category);
        }

        // POST: Categories/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(Category category)
        {
            if (category == null)
            {
                return NotFound();
            }


            using (var httpClient = new HttpClient())
            {
                StringContent stringContent = new StringContent(JsonConvert.SerializeObject(category), Encoding.UTF8, "application/json");
                using (var response = await httpClient.PutAsync("https://localhost:44383/api/Categories/" + category.Id, stringContent))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        return RedirectToAction(nameof(Index));
                    }
                }
            }

            return View(category);
        }


        // GET: Categories/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Category category = new Category();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync("https://localhost:44383/api/Categories/" + id))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        var content = await response.Content.ReadAsStringAsync();
                        category = JsonConvert.DeserializeObject<Category>(content);
                    }
                }
            }

            return View(category);
        }

        // POST: Categories/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.DeleteAsync("https://localhost:44383/api/Categories/" + id))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        return RedirectToAction(nameof(Index));
                    }
                    return BadRequest("Faild Delete,try again");
                }
            }


        }




    }
}
