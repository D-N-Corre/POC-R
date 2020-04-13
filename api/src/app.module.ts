import { Module } from '@nestjs/common';
import { GraphQLModule } from '@nestjs/graphql';

import { AppController } from './app.controller';
import { AppService } from './app.service';

import { SecurityModule } from './security/security.module';
import { TimerModule } from './timer/timer.module';
import { TournamentModule } from './tournament/tournament.module';
import { UserModule } from './user/user.module';
import { GameModule } from './game/game.module';

@Module({
  imports: [

    SecurityModule,
    TimerModule,
    TournamentModule,
    UserModule,
    GameModule,

    GraphQLModule.forRoot({
      include: [
        TimerModule,
        TournamentModule,
        UserModule,
        GameModule,
      ],
      typePaths: ['./**/*.graphql'],
    }),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule { }
