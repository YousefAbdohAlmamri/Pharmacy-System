using Pharmacy_API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Pharmacy_API.DTOs
{
    public class PharmacyDetailsDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Location { get; set; }
        public string Phone { get; set; }
        public User? User { get; set; }
        public string? ImageUrl { get; set; }
        public List<PharmacyMedicineViewDto> Medicines { get; set; }
        //public string Medicines { get; set; }
    }
}
