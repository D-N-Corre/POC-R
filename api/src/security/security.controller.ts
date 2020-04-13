import { Controller, Get, UseGuards, Req, Res } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';

import { AuthenticateService } from './services/authenticate.service';

@Controller('auth')
export class SecurityController {

    constructor(private readonly authenticateService: AuthenticateService) { }

    @Get('google')
    @UseGuards(AuthGuard('google'))
    googleLogin() {
        // initiates the Google OAuth2 login flow
    }

    @Get('google/callback')
    @UseGuards(AuthGuard('google'))
    googleLoginCallback(@Req() req, @Res() res) {
        // handles the Google OAuth2 callback
        console.log(req.user);
        const jwt: string = req.user.jwt;
        if (jwt)
            res.redirect('http://localhost:4200/login/succes/' + jwt);
        else
            res.redirect('http://localhost:4200/login/failure');
    }
}