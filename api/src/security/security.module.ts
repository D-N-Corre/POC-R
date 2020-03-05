import { Module } from '@nestjs/common';
import { AuthenticateService } from './services/authenticate.service';
import { SecurityResolvers } from './security.resolvers';

@Module({
  providers: [SecurityResolvers, AuthenticateService]
})
export class AuthenticateModule { }
