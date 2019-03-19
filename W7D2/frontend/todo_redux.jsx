import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';

document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state ?
    JSON.parse(localStorage.state) : {};
  let store = configureStore(preloadedState);
  // store.dispatch = addLoggingToDispatch(store); 
  store = applyMiddleWares(store, addLoggingToDispatch); 
  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});

// function addLoggingToDispatch(store) {
//   return function (next) {
//     return function (action) {
//       console.log(store.getState());
//       console.log(action);
//       next(action);
//       console.log(store.getState());
//     };
//   };
// }




// Part I. 
// const addLoggingToDispatch = (store) => {
//   const currStore = store.dispatch; 
//   return (action) => {
//     console.log(store.getState()); 
//     console.log(action); 
//     currStore(action); 
//     console.log(store.getState()); 
//   };
// };