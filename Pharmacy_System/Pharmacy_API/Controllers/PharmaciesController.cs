using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Pharmacy_API.DTOs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Pharmacy_API.Data;
using Pharmacy_API.Models;
using Newtonsoft.Json;
using System.IO;
using Microsoft.AspNetCore.Hosting;

namespace Pharmacy_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PharmaciesController : ControllerBase
    {
        private readonly AppDBContext _context;
        private readonly IWebHostEnvironment _environment;
        public PharmaciesController(AppDBContext context, IWebHostEnvironment environment)
        {
            _context = context;
            _environment = environment;
        }

        // GET: api/Pharmacies
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Pharmacy>>> GetPharmacies()
        {
            var pharmacies = await _context.Pharmacies.Include(d => d.User).Include(p => p.PharmacyMedicines).ThenInclude(pm => pm.Medicine).ToListAsync();
      
            /*var pharmacies = await _context.Pharmacies.Include(d => d.User).Include(p => p.PharmacyMedicines).ThenInclude(pm => pm.Medicine).ThenInclude(p => p.Category).ToListAsync();

            var result = pharmacies.Select(p => new PharmacyDto
            {
                Id = p.Id,
                Name = p.Name,
                Description = p.Description,
                ImageUrl = p.ImageUrl,
                Location = p.Location,
                Phone = p.Phone,
                User = p.User,
                PharmacyMedicines = p.PharmacyMedicines.Select(pm => new PharmacyMedicineDtos
                {
                    MedicineId = pm.MedicineId,
                    Stock = pm.Stock,
                    Medicine = new MedicineDto
                    { 
                      Id = pm.Medicine.Id,
                        
                        Name = pm.Medicine.Name,
                        Description = pm.Medicine.Description,
                        Company = pm.Medicine.Company,
                        MadeIn = pm.Medicine.MadeIn,
                        Price = pm.Medicine.Price,
                        DateCreated = pm.Medicine.DateCreated,
                        ExpirationDate = pm.Medicine.ExpirationDate,
                        ImageUrl = pm.Medicine.ImageUrl,
                        Category = new CategoryDto
                        {
                            Id = pm.Medicine.Category.Id,
                            Name = pm.Medicine.Category.Name,
                        }
                    }
                }
                ).ToList()
            }
            ).ToList();*/

            /*var result = pharmacies.Select(p => new PharmacyDetailsDto
            {
                Id = p.Id,
                Name = p.Name,
                Description = p.Description,
                ImageUrl = p.ImageUrl,
                Location = p.Location,
                Phone = p.Phone,
                User = p.User,
                Medicines = p.PharmacyMedicines.Select(pm => new PharmacyMedicineViewDto
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

            return Ok(pharmacies);
        }

        // GET: api/Pharmacies/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Pharmacy>> GetPharmacy(int id)
        {
            var pharmacy = await _context.Pharmacies.Include(u => u.User).Include(p => p.PharmacyMedicines).ThenInclude(pm => pm.Medicine).ThenInclude(d => d.Category).FirstOrDefaultAsync(d => d.Id == id);


            
            if (pharmacy == null)
            {
                return NotFound();
            }


            /*var result = new PharmacyDetailsDto
            {
                Id = pharmacy.Id,
                Name = pharmacy.Name,
                Description = pharmacy.Description,
                ImageUrl = pharmacy.ImageUrl,
                Location = pharmacy.Location,
                Phone = pharmacy.Phone,
                User = pharmacy.User,
                Medicines = pharmacy.PharmacyMedicines.Select(pm => new PharmacyMedicineViewDto
                {
                    MedicineId = pm.MedicineId,
                    Name = pm.Medicine.Name,
                    CategoryId = pm.Medicine.CategoryId,
                    Stock = pm.Stock
                }
                ).ToList()
            };
*/

            return Ok(pharmacy);
            
        }


        // GET: api/Pharmacies/search?name=
        [HttpGet("search/{name}")]
        public async Task<IActionResult> SearchMedicine(string name)
        {
            //var result = await _context.PharmacyMedicines.Include(me => me.Medicine).ThenInclude(c => c.Category).Include(ph => ph.Pharmacy).Where(meN => meN.Medicine.Name.Contains(name)).ToListAsync();
            var pharmacies = await _context.PharmacyMedicines.Include(me => me.Medicine).Include(ph => ph.Pharmacy).Where(meN => meN.Medicine.Name.Contains(name)).Select(pha => new
            {
                Id = pha.Pharmacy.Id,
                Name = pha.Pharmacy.Name,
                Description = pha.Pharmacy.Description,
                Location = pha.Pharmacy.Location,
                Phone = pha.Pharmacy.Phone,
                ImageUrl = pha.Pharmacy.ImageUrl,
            }).ToListAsync();
           return Ok(pharmacies);
        }


        [HttpGet("PharmacysMedicines/{pharmacyId}")]
        public async Task<IActionResult> PharmacysMedicines(int pharmacyId)
        {
            var medicines =await _context.PharmacyMedicines.Include(m => m.Medicine).Include(p => p.Pharmacy).Where(pId => pId.PharmacyId == pharmacyId).Select(med => new
            {
                Id = med.MedicineId,
                Name = med.Medicine.Name,
                Description = med.Medicine.Description,
                Company = med.Medicine.Company,
                MadeIn = med.Medicine.MadeIn,
                Price = med.Medicine.Price,
                DateCreated = med.Medicine.DateCreated,
                ExpirationDate = med.Medicine.ExpirationDate,
                ImageName = med.Medicine.ImageUrl,
                Stock = med.Stock,
                CategoryName = med.Medicine.Category.Name,

            }).ToListAsync();

            return Ok(medicines);
        }

        // PUT: api/Pharmacies/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> PutPharmacy(int id, [FromForm] CreatePharmacyDto dto)
        {

            if (dto.ImageFile == null || dto.ImageFile.Length == 0)
            {
                return BadRequest("يرجاء ادخال الصورة");
            }

            string fileName = dto.ImageFile.FileName;
            string uploadsFolder = Path.Combine(_environment.WebRootPath, "Images");
            if (!Directory.Exists(uploadsFolder))
            {
                Directory.CreateDirectory(uploadsFolder);
            }
            string filePath = Path.Combine(uploadsFolder, fileName);
            using (Stream stream = new FileStream(filePath, FileMode.Create))
            {
                await dto.ImageFile.CopyToAsync(stream);
            }

            var pharmacy = new Pharmacy
            {
                Id = dto.Id,
                Name = dto.Name,
                Description = dto.Description,
                ImageUrl = fileName,
                Location = dto.Location,
                Phone = dto.Phone,
                UserId = dto.UserId

            };

            /*if (id != dto.Id)
            {
                return BadRequest();
            }

            var pharmacy = new Pharmacy
            {
                Id = dto.Id,
                Name = dto.Name,
                Description = dto.Description,
                //ImageUrl = dto.ImageUrl,
                Location = dto.Location,
                Phone = dto.Phone,
                UserId = dto.UserId
            };
*/

            //_context.Entry(pharmacy).State = EntityState.Modified;


            _context.Pharmacies.Update(pharmacy);
                await _context.SaveChangesAsync();

            var medicines = JsonConvert.DeserializeObject<List<PharmacyMedicineDto>>(dto.Medicines);


            foreach (var medicineDto in medicines)
                {
                    var pharmacyMedicine = new PharmacyMedicine
                    {
                        PharmacyId = pharmacy.Id,
                        MedicineId = medicineDto.MedicineId,
                        Stock = medicineDto.Stock
                    };
                    _context.PharmacyMedicines.Update(pharmacyMedicine);
                }

                await _context.SaveChangesAsync();

            
            return Ok(pharmacy);
        }

        // POST: api/Pharmacies
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        /*[HttpPost]
        public async Task<ActionResult<Pharmacy>> PostPharmacy(Pharmacy pharmacy)
        {
            _context.Pharmacies.Add(pharmacy);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPharmacy", new { id = pharmacy.Id }, pharmacy);
        }
        */
        [HttpPost]
        [Consumes("multipart/form-data")]
        public async Task<ActionResult<Pharmacy>> PostPharmacy([FromForm] CreatePharmacyDto dto)
        {

            if (dto.ImageFile == null || dto.ImageFile.Length == 0)
            {
                return BadRequest("يرجاء ادخال الصورة");
            }

            string fileName = dto.ImageFile.FileName;
            string uploadsFolder = Path.Combine(_environment.WebRootPath, "Images");
            if (!Directory.Exists(uploadsFolder))
            {
                Directory.CreateDirectory(uploadsFolder);
            }
            string filePath = Path.Combine(uploadsFolder, fileName);
            using (Stream stream = new FileStream(filePath, FileMode.Create))
            {
                await dto.ImageFile.CopyToAsync(stream);
            }

            var pharmacy = new Pharmacy
            {
                //Id = dto.Id,
                Name = dto.Name,
                Description = dto.Description,
                ImageUrl = fileName,
                Location = dto.Location,
                Phone = dto.Phone,
                UserId = dto.UserId
                
            };

            /*if (string.IsNullOrWhiteSpace(dto.Name))
                return BadRequest("يرجاء ادخال اسم الصيدلية");

            var pharmacy = new Pharmacy
            {
                Name = dto.Name,
                Description = dto.Description,
                ImageUrl = dto.ImageUrl,
                Location = dto.Location,
                Phone = dto.Phone,
                UserId =dto.UserId
            };

            */
            _context.Pharmacies.Add(pharmacy);
            await _context.SaveChangesAsync();


            var medicines = JsonConvert.DeserializeObject<List<PharmacyMedicineDto>>(dto.Medicines);

            foreach (var medicineDto in medicines)
            {
                var pharmacyMedicine = new PharmacyMedicine
                {
                    PharmacyId = pharmacy.Id,
                    MedicineId = medicineDto.MedicineId,
                    Stock = medicineDto.Stock
                };
                _context.PharmacyMedicines.Add(pharmacyMedicine);
            }

            await _context.SaveChangesAsync();
            return CreatedAtAction("GetPharmacy", new { id = pharmacy.Id }, pharmacy);
        }


        // Get: api/Pharmacies/Medicines
        [HttpGet("Medicines")]
        public async Task<IActionResult> GetMedicinesWithCategory()
        {
            var medicines = await _context.Medicines.Include(d => d.Category).ToListAsync();

            return Ok(medicines);
        }




        // DELETE: api/Pharmacies/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Pharmacy>> DeletePharmacy(int id)
        {
            var pharmacy = await _context.Pharmacies.FindAsync(id);
            if (pharmacy == null)
            {
                return NotFound();
            }

            _context.Pharmacies.Remove(pharmacy);
            await _context.SaveChangesAsync();

            return pharmacy;
        }

        private bool PharmacyExists(int id)
        {
            return _context.Pharmacies.Any(e => e.Id == id);
        }
    }
}
