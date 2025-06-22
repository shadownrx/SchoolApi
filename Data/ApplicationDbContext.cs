
using Microsoft.EntityFrameworkCore;
using SchoolApi.Models;

namespace SchoolApi.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options) { }

    public DbSet<User> Users => Set<User>();
}
