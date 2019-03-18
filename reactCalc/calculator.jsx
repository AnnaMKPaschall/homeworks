import React from 'react';

class Calculator extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            result: 0, 
            num1: "", 
            num2: ""
        };
        this.setNum1 = this.setNum1.bind(this); 
        this.setNum2 = this.setNum2.bind(this); 
        this.add = this.add.bind(this); //binds this within add fn. 
        this.subtract = this.subtract.bind(this); 
        this.multiply = this.multiply.bind(this); 
        this.division = this.division.bind(this); 
        this.clear = this.clear.bind(this); 


        // your code here
    }

    setNum1(e) {
        const num1 = e.target.value ? parseInt(e.target.value) : "";
        this.setState({num1});  
    }

    setNum2(e) {
        const num2 = e.target.value ? parseInt(e.target.value) : ""; 
        this.setState({num2}); 
    }

    add(e) {
        e.preventDefault(); 
        const result = this.state.num2 + this.state.num1; 
        this.setState({result}); 
    }

    subtract(e) {
        e.preventDefault(); 
        const result = this.state.num1 - this.state.num2; 
        this.setState({result}); 
    }

    multiply(e) {
        e.preventDefault(); 
        const result = this.state.num1 * this.state.num2; 
        this.setState({result});
    }

    division(e) {
        e.preventDefault(); 
        const result = this.state.num1 / this.state.num2; 
        this.setState({result}); 
    }

    clear(e) {
        e.preventDefault(); 
        this.state.num1 = ""; 
        this.setState({result: 0, num1: "", num2: ""}); 
    }
    // your code here

    render() {
        const {num1, num2, result} = this.state; 
        return (
            <div id="calc">
                {/* <h1>John's Fancy Calc</h1> */}
                <h1>{result}</h1>
                <input onChange={this.setNum1} value={num1}/>
                <input onChange={this.setNum2} value={num2}/>
                <button onClick={this.clear}>Clear</button>
            <br/>
                <button onClick={this.add}>+</button>
                <button onClick={this.subtract}>-</button>
                <button onClick={this.multiply}>*</button>
                <button onClick={this.division}>/</button>
            </div>
        );
    }
}

export default Calculator;