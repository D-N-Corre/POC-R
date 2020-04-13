import { Module } from '@nestjs/common';
import { AuthenticateService } from './services/authenticate.service';
import { SecurityController } from './security.controller';
import { GoogleStrategy } from './strategies/google.strategy';

@Module({
  controllers: [SecurityController],
  providers: [
    AuthenticateService,
    GoogleStrategy,
  ]
})
export class SecurityModule { }
