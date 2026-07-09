using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace Pharmacy_API.Models
{
    public class Medicine
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
        public string? ImageUrl { get; set; }
       /*[NotMapped]
        public IFormFile? ImageFile { get; set; }
        */public string? Company { get; set; }
        public string? MadeIn { get; set; }
        public decimal? Price { get; set; }
        public DateTime? DateCreated { get; set; }   // تاريخ الانشاء
        public DateTime? ExpirationDate { get; set; }    // تاريخ الانتهاء 

        public List<PharmacyMedicine> PharmacyMedicines { get; set; }

        public int? CategoryId { get; set; }
        public Category? Category { get; set; }
    }
}
