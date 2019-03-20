import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';
import { fetchSearchGiphys } from './util/api_util';
// import {receiveSearchGiphys} from './actions/giphy_actions'; 


window.fetchSearchGiphys = fetchSearchGiphys; 
// window.store = store; 
// window.receiveSearchGiphys = receiveSearchGiphys; 

// document.addEventListener("DOMContentLoaded", () => {
//     const rootEl = document.getElementById("root"); 
//     const store = configureStore(); 
//     ReactDOM.render(<Root store={store}/>, rootEl); 
// });

