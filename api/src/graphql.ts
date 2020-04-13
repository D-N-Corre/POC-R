
/** ------------------------------------------------------
 * THIS FILE WAS AUTOMATICALLY GENERATED (DO NOT MODIFY)
 * -------------------------------------------------------
 */

/* tslint:disable */
export abstract class IMutation {
    abstract authenticate(username: string, password: string): User | Promise<User>;

    abstract logout(): boolean | Promise<boolean>;
}

export abstract class IQuery {
    abstract getTournament(id: number): Tournament | Promise<Tournament>;

    abstract getAllTournaments(): Tournament[] | Promise<Tournament[]>;
}

export class Tournament {
    id: number;
    name?: string;
}

export class User {
    id: number;
    name?: string;
}
