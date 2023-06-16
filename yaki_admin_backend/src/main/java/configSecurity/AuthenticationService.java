package configSecurity;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthenticationService {
    private final UserJpaRepository repository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;


    public AuthenticationResponse register(RegisterRequest request) {
        UserModel user = new UserModel(
                request.getLastname(),
                request.getFirstname(),
                request.getEmail(),
                request.getLogin(),
                request.getPassword());
        repository.save(user);
        var jwtToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder()
                .token(jwtToken)
                .build();
    }

    public AuthenticationResponse authenticate(AuthenticationRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()
                )
        );
<<<<<<< HEAD
        UserModel user = repository.findByEmail(request.getEmail())
=======
        var user = repository.findByEmail(request.getEmail())
>>>>>>> c273ed2 (feat(athentication): configuration security jwt authent)
                .orElseThrow();
        var jwtToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder()
                .token(jwtToken)
                .build();
    }
}
