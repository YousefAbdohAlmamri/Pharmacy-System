using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Pharmacy_API.Data;
using Pharmacy_API.Models;

namespace Pharmacy_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PharmacyMedicinesController : ControllerBase
    {
        private readonly AppDBContext _context;

        public PharmacyMedicinesController(AppDBContext context)
        {
            _context = context;
        }

        // GET: api/PharmacyMedicines
        [HttpGet()]
        public async Task<ActionResult<IEnumerable<PharmacyMedicine>>> GetPharmacyMedicines()
        {
            return await _context.PharmacyMedicines.Include(pm => pm.Medicine).Include(pm => pm.Pharmacy).ToListAsync();
        }

        // GET: api/PharmacyMedicines/5
        [HttpGet("{pharmacyId}/{medicineId}")]
        public async Task<ActionResult<PharmacyMedicine>> GetPharmacyMedicine(int pharmacyId, int medicineId)
        {
            var item = await _context.PharmacyMedicines.Include(pm => 
                pm.Medicine).Include(pm =>
                pm.Pharmacy).FirstOrDefaultAsync(pm =>
                pm.PharmacyId == pharmacyId &&
                pm.MedicineId == medicineId);


            if (item == null)
            {
                return NotFound();
            }

            return item;
        }

        // PUT: api/PharmacyMedicines/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{pharmacyId}/{medicineId}")]
        public async Task<IActionResult> PutPharmacyMedicine(int pharmacyId, int medicineId, PharmacyMedicine pharmacyMedicine)
        {
            if (pharmacyId != pharmacyMedicine.PharmacyId || medicineId != pharmacyMedicine.MedicineId)
            {
                return BadRequest();
            }

            //_context.Entry(pharmacyMedicine).State = EntityState.Modified;

            try
            {
                _context.PharmacyMedicines.Update(pharmacyMedicine);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                return NotFound();
            }

            return NoContent();
        }

        // POST: api/PharmacyMedicines
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<PharmacyMedicine>> PostPharmacyMedicine(PharmacyMedicine pharmacyMedicine)
        {
            _context.PharmacyMedicines.Add(pharmacyMedicine);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPharmacyMedicine", new { id = pharmacyMedicine.PharmacyId }, pharmacyMedicine);
        }

        // DELETE: api/PharmacyMedicines/5
        [HttpDelete("{pharmacyId}/{medicineId}")]
        public async Task<ActionResult<PharmacyMedicine>> DeletePharmacyMedicine(int pharmacyId, int medicineId)
        {
            var item = await _context.PharmacyMedicines.FirstOrDefaultAsync(pm =>
                pm.PharmacyId == pharmacyId &&
                pm.MedicineId == medicineId);
            
            if (item == null)
            {
                return NotFound();
            }

            _context.PharmacyMedicines.Remove(item);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PharmacyMedicineExists(int id)
        {
            return _context.PharmacyMedicines.Any(e => e.PharmacyId == id);
        }
    }
}
