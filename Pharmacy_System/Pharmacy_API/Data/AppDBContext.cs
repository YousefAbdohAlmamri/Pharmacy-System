using Microsoft.EntityFrameworkCore;
using Pharmacy_API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Pharmacy_API.Data
{
    public class AppDBContext:DbContext
    {
        public AppDBContext(DbContextOptions<AppDBContext> options) : base(options) { }
        
        public DbSet<User> Users { get; set; } 
        public DbSet<Category> Categories { get; set; } 
        public DbSet<Medicine> Medicines { get; set; } 
        public DbSet<Pharmacy> Pharmacies { get; set; } 
        public DbSet<PharmacyMedicine> PharmacyMedicines { get; set; } 


            // تعيين مفتاح مركب للجدول الوسيط بين الصيدلية و الدواء لان العلاقة عديد الى عديد
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<PharmacyMedicine>().HasKey(pd => new{pd.PharmacyId, pd.MedicineId});
        }
    }
}
