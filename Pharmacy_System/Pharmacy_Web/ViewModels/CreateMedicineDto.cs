using Microsoft.AspNetCore.Http;
using Pharmacy_Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Pharmacy_Web.ViewModels
{
    public class CreateMedicineDto
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
        public string? Company { get; set; }
        public string? MadeIn { get; set; }
        public decimal? Price { get; set; }
        public DateTime? DateCreated { get; set; }   // تاريخ الانشاء
        public DateTime? ExpirationDate { get; set; }    // تاريخ الانتهاء
        public int? CategoryId { get; set; }
        public Category Category { get; set; }
        public IFormFile ImageFile { get; set; }
    }
}
