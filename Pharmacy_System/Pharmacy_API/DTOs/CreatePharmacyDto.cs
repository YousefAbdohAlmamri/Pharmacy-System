using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace Pharmacy_API.DTOs
{
    public class CreatePharmacyDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Location { get; set; }
        public string Phone { get; set; }
        public int UserId { get; set; }
        public IFormFile ImageFile { get; set; }
        //public string? ImageUrl { get; set; }
        //public List<PharmacyMedicineDto> Medicines { get; set; }
        public string Medicines { get; set; }
    }
}
