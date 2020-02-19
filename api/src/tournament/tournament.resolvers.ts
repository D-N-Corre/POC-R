import { Resolver, Query, Args } from '@nestjs/graphql';
import { TournamentService } from './services/tournament.service';

import { Tournament } from './../graphql';

@Resolver('Tournament')
export class TournamentResolvers {
    
    constructor(private readonly tournamentService: TournamentService){}

    @Query()
    async getTournament(@Args('id') id: Number): Promise<Tournament> {
        const helloTournament: Tournament = new Tournament(); 
        helloTournament.id = 5;
        helloTournament.name = 'Premier test avec HMR';
        return new Promise((resolve) => resolve(helloTournament));
    }
    
    @Query()
    async getAllTournaments(): Promise<Tournament[]> {
        const listTournament: Tournament[] = new Array();
        
        const helloTournament: Tournament = new Tournament(); 
        helloTournament.id = 5;
        helloTournament.name = 'Premier test';
        
        listTournament.push(helloTournament);
        listTournament.push(helloTournament);
        listTournament.push(helloTournament);
        
        return new Promise((resolve) => resolve(listTournament));
    }
}