export const RECEIVE_SEARCH_GIPHYS = 'RECEIVE_SEARCH_GIPHYS';

import * as APIUtil from '../util/api_util';

export const receiveSearchGiphys = giphys => {
    return {
        type: RECEIVE_SEARCH_GIPHYS,
        giphys
    }; 
};

