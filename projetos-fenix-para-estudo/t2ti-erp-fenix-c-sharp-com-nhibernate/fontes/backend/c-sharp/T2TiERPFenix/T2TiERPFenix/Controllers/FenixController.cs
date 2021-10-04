using Microsoft.AspNetCore.Mvc;
using System;

namespace T2TiERPFenix.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class FenixController : ControllerBase
    {
        [HttpGet]
        public String Get()
        {
            return "{Bem-vindo ao T2Ti ERP Fenix}";
        }
    }
}
