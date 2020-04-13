
import { Injectable } from '@nestjs/common';
import { PassportStrategy } from "@nestjs/passport";
import { OAuth2Strategy } from 'passport-google-oauth';


@Injectable()
export class GoogleStrategy extends PassportStrategy(OAuth2Strategy, 'google') {
    constructor() {
        super({
            clientID: '244114202437-bkbbjng18bl1epge0agi3f7b3e4cgrlo.apps.googleusercontent.com',
            clientSecret: '-rwewl8GHPPUFWvwzARBKSC0',
            callbackURL: 'http://localhost:3000/auth/google/callback',
            passReqToCallback: true,
            scope: ['profile']
        });
    }

    async validate(request: any, accessToken: string, refreshToken: string, profile, done: Function) {
        try {
            console.log(profile);

            const jwt: string = 'placeholderJWT';
            const user = { jwt };

            done(null, user);
        }
        catch (err) {
            // console.log(err)
            done(err, false);
        }
    }
}