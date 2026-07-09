using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Pharmacy_API.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Pharmacy_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DashBoardController : ControllerBase
    {
        private readonly AppDBContext _context;

        public DashBoardController(AppDBContext context)
        {
            _context = context;
        }

        [HttpGet("stats")]
        public IActionResult GetStats()
        {
            var stats = new
            {
                UsersCount = _context.Users.Count(),
                CategoriesCount = _context.Categories.Count(),
                MedicinesCount = _context.Medicines.Count(),
                PharmaciesCount = _context.Pharmacies.Count()
            };

            return Ok(stats);
        }
    }
}
