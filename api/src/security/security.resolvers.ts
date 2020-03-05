import { Resolver, Query, Args } from '@nestjs/graphql';
import { AuthenticateService } from './services/authenticate.service';

import { Tournament } from '../graphql';

@Resolver('Security')
export class SecurityResolvers {

    constructor(private readonly authenticateService: AuthenticateService) { }

    @Query()
    async authenticate(@Args('username') username: String, @Args('password') password: String): Promise<Tournament> {
        return new Promise((resolve) => resolve(new Tournament()));
    }
}