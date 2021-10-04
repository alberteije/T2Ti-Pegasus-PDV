using Microsoft.EntityFrameworkCore;
using T2TiERPFenix.Models;

namespace T2TiERPFenix.Repository
{
    public class RepositoryContext : DbContext
    {

        public RepositoryContext(DbContextOptions options)
                    : base(options)
        {
        }

        public DbSet<Cargo> Cargos { get; set; }
        public DbSet<Banco> Bancos { get; set; }
        public DbSet<BancoAgencia> BancoAgencias { get; set; }
        public DbSet<Pessoa> Pessoas { get; set; }

    }
}
