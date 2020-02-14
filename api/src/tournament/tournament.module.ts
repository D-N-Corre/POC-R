import { Module } from '@nestjs/common';
import { TournamentService } from './services/tournament.service';
import { TournamentResolvers } from './tournament.resolvers';

@Module({
  providers: [ TournamentResolvers, TournamentService ]
})
export class TournamentModule {}
