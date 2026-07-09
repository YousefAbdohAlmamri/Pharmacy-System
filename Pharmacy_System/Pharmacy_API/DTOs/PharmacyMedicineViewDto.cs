using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Pharmacy_API.DTOs
{
    public class PharmacyMedicineViewDto
    {
        public int MedicineId { get; set; }
        public string Name { get; set; }
        public int? CategoryId { get; set; }
        public int? Stock { get; set; }
    }
}
