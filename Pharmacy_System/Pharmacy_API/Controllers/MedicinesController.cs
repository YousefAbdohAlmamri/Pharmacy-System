using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Pharmacy_API.Data;
using Pharmacy_API.DTOs;
using Pharmacy_API.Models;

namespace Pharmacy_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MedicinesController : ControllerBase
    {
        private readonly AppDBContext _context;
        private readonly IWebHostEnvironment _environment ;

        public MedicinesController(AppDBContext context, IWebHostEnvironment environment)
        {
            _context = context;
            _environment = environment;
        }

        // GET: api/Medicines
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Medicine>>> GetMedicines()
        {
            var medicines = await _context.Medicines.Include(d => d.Category).ToListAsync();

            return Ok(medicines);
        }

        // GET: api/Medicines/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Medicine>> GetMedicine(int id)
        {
            var medicine = await _context.Medicines.Include(d => d.Category).Where(d => d.Id == id).FirstOrDefaultAsync();

            if (medicine == null)
            {
                return NotFound();
            }

            return medicine;
        }
        
        // GET: api/Medicines/5
        /*
        [HttpGet("search")]
        public async Task<ActionResult<Medicine>> GetMedicineByName(string medicineName)
        {
            var medicine = await _context.Medicines.FirstOrDefaultAsync(medicineName);

            if (medicine == null)
            {
                return NotFound();
            }

            return medicine;
        }
        */
        // PUT: api/Medicines/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> PutMedicine(int id, [FromForm] CreateMedicineDto medicineDto)
        {

            /*if (medicineDto.ImageFile == null || medicineDto.ImageFile.Length == 0)
            {
                return BadRequest("يرجاء ادخال الصورة");
            }

            string fileName = medicineDto.ImageFile.FileName;
            string filePath = Path.Combine(@"C:\Users\YOUSEF\source\repos\Pharmacy_System\Pharmacy_API\wwwroot\Images", fileName);

            using (Stream stream = new FileStream(filePath, FileMode.Create))
            {
                await medicineDto.ImageFile.CopyToAsync(stream);
            }

            var medicine = new Medicine
            {
                Id = medicineDto.Id,
                Name = medicineDto.Name,
                Description = medicineDto.Description,
                Company = medicineDto.Company,
                MadeIn = medicineDto.MadeIn,
                Price = medicineDto.Price,
                DateCreated = medicineDto.DateCreated,
                ExpirationDate = medicineDto.ExpirationDate,
                Category = medicineDto.Category,
                ImageUrl = fileName
            };*/
            if (medicineDto.ImageFile == null || medicineDto.ImageFile.Length == 0)
            {
                return BadRequest("يرجاء ادخال الصورة");
            }

            string fileName = medicineDto.ImageFile.FileName;
            string uploadsFolder = Path.Combine(_environment.WebRootPath, "Images");
            if (!Directory.Exists(uploadsFolder))
            {
                Directory.CreateDirectory(uploadsFolder);
            }
            string filePath = Path.Combine(uploadsFolder, fileName);
            using (Stream stream = new FileStream(filePath, FileMode.Create))
            {
                await medicineDto.ImageFile.CopyToAsync(stream);
            }

            var medicine = new Medicine
            {
                Id = medicineDto.Id,
                Name = medicineDto.Name,
                Description = medicineDto.Description,
                Company = medicineDto.Company,
                MadeIn = medicineDto.MadeIn,
                Price = medicineDto.Price,
                DateCreated = medicineDto.DateCreated,
                ExpirationDate = medicineDto.ExpirationDate,
                CategoryId = medicineDto.CategoryId,
                //Category = medicineDto.Category,
                ImageUrl = fileName
                //ImageUrl = "/Images/"+fileName
            };
            if (id != medicine.Id)
            {
                return BadRequest();
            }

            //_context.Entry(medicine).State = EntityState.Modified;

            try
            {
                _context.Medicines.Update(medicine);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!MedicineExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Medicines
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<ActionResult<Medicine>> PostMedicine([FromForm] CreateMedicineDto medicineDto)
        {
            if (medicineDto.ImageFile == null || medicineDto.ImageFile.Length == 0)
            {
                return BadRequest("يرجاء ادخال الصورة");
            }

            string fileName = medicineDto.ImageFile.FileName;
            string uploadsFolder = Path.Combine(_environment.WebRootPath, "Images");
            if (!Directory.Exists(uploadsFolder))
            {
                Directory.CreateDirectory(uploadsFolder);
            }
            string filePath = Path.Combine(uploadsFolder, fileName);
            using (Stream stream = new FileStream(filePath,FileMode.Create))
            {
                await medicineDto.ImageFile.CopyToAsync(stream);
            }

            var medicine = new Medicine
            {
                //Id = medicineDto.Id,
                Name = medicineDto.Name,
                Description = medicineDto.Description,
                Company = medicineDto.Company,
                MadeIn = medicineDto.MadeIn,
                Price = medicineDto.Price,
                DateCreated = medicineDto.DateCreated,
                ExpirationDate = medicineDto.ExpirationDate,
                CategoryId = medicineDto.CategoryId,
                //Category = medicineDto.Category,
                ImageUrl = fileName
                //ImageUrl = "/Images/"+fileName
            };
            _context.Medicines.Add(medicine);
            await _context.SaveChangesAsync();

            //return CreatedAtAction("GetMedicine", new { id = medicine.Id }, medicine);
            return Ok(medicine);
        }

        // DELETE: api/Medicines/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Medicine>> DeleteMedicine(int id)
        {
            var medicine = await _context.Medicines.FindAsync(id);
            if (medicine == null)
            {
                return NotFound();
            }

            _context.Medicines.Remove(medicine);
            await _context.SaveChangesAsync();

            return medicine;
        }

        private bool MedicineExists(int id)
        {
            return _context.Medicines.Any(e => e.Id == id);
        }
    }
}
