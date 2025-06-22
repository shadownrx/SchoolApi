using Microsoft.AspNetCore.Mvc;
using SchoolApi.Models;
using SchoolApi.Services;

namespace SchoolApi.Controllers;

[ApiController]
[Route("api/auth")]
public class AuthController : ControllerBase
{
    private readonly JwtService _jwtService;

    public AuthController(JwtService jwtService)
    {
        _jwtService = jwtService;
    }

    [HttpPost("login")]
    public IActionResult Login([FromBody] LoginRequest request)
    {
        // Simulación simple
        if (request.Username == "admin" && request.Password == "password")
        {
            var user = new User { Id = 1, Username = "admin" };
            var token = _jwtService.GenerateToken(user);
            return Ok(new { token });
        }

        return Unauthorized(new { message = "Credenciales inválidas" });
    }
}

public class LoginRequest
{
    public string Username { get; set; } = null!;
    public string Password { get; set; } = null!;
}
