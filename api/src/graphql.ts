
/** ------------------------------------------------------
 * THIS FILE WAS AUTOMATICALLY GENERATED (DO NOT MODIFY)
 * -------------------------------------------------------
 */

/* tslint:disable */
export abstract class IQuery {
    abstract getTournament(id: number): Tournament | Promise<Tournament>;

    abstract getAllTournaments(): Tournament[] | Promise<Tournament[]>;
}

export class Tournament {
    id: number;
    name?: string;
}
