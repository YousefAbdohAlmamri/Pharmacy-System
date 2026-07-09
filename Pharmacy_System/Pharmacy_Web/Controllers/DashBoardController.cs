using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Pharmacy_Web.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace Pharmacy_Web.Controllers
{
    public class DashBoardController : Controller
    {
        public async Task<IActionResult> Index()
        {
            var stats = new DashboardStats();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync("https://localhost:44383/api/DashBoard/stats"))
                {
                    if (response.IsSuccessStatusCode)
                    {
                        var content = await response.Content.ReadAsStringAsync();
                        stats = JsonConvert.DeserializeObject<DashboardStats>(content);   
                    }
                }
            }
            return View(stats);

        }
    }
}
