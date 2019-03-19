import { createStore } from 'redux';
import rootReducer from '../reducers/root_reducer';
import { applyMiddleware } from 'redux'; 

const configureStore = (preloadedState = {}) => {
  const store = createStore(rootReducer, preloadedState, 
    applyMiddleware(addLoggingToDispatch, middlewares)
    // need to add in function to generate ^ these middlewares 
    
    );
  store.subscribe(() => {
    localStorage.state = JSON.stringify(store.getState());
  });
  return store;
}

function addLoggingToDispatch(store) {
  return function (next) {
    return function (action) {
      console.log(store.getState());
      console.log(action);
      next(action);
      console.log(store.getState());
    };
  };
}

const applyMiddlewares = (store, ...middlewares) => {
  const dispatch = store.dispatch;
  middlewares.forEach((ele) => {
    dispatch = ele(store)(dispatch);
  });
  return Object.assign({}, store, { dispatch });
}; 



export default configureStore;
