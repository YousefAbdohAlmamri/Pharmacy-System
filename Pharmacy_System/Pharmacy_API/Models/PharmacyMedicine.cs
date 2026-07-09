using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Pharmacy_API.Models
{
    public class PharmacyMedicine
    {
        public int PharmacyId { get; set; }
        public Pharmacy Pharmacy { get; set; }
        
        public int MedicineId { get; set; }
        public Medicine Medicine { get; set; }

        public int? Stock { get; set; }
    }
}
