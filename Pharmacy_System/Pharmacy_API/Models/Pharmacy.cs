using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Pharmacy_API.Models
{
    public class Pharmacy
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
        public string? ImageUrl { get; set; }
        public string? Location { get; set; }
        public string? Phone { get; set; }

        public int? UserId { get; set; }
        public User? User { get; set; }

        public List<PharmacyMedicine> PharmacyMedicines { get; set; }
    }
}
