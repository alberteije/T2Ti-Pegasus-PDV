using Microsoft.AspNetCore.Mvc;
using System;

namespace T2TiRetaguardaSH.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RetaguardaSHController : ControllerBase
    {
        [HttpGet]
        public String Get()
        {
            return "{Bem-vindo a Retaguarda da Software House da T2Ti}";
        }
    }
}
