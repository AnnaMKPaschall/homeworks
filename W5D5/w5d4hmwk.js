window.setTimeout(function () {
    alert('HAMMERTIME!');
}, 5000);


window.setTimeout(function hammerTime(time) {
    console.log(`$(time) is hammertime!`)
}); 


const readline = require('readline'); 
const reader = readline.createInterface({
    input: process.stdin, 
    output: process.stdout
}); 

function teaAndBiscuits() {
    let first, second; 

    reader.question('Would you like some tea?', (res) => {
        let first = res; 
    }); 

    const firstRes = (first === "yes") ? 'DO' : 'DO NOT';   

    console.log(`Okay, to clarify you ${firstRes} some tea.`); 
  
    reader.question('Would you like some biscuits?', (res) => {
        let second = res;
    }); 

    const secondRes = (second === "no" ? "DO" : "DO NOT"); 

    console.log(`Okay great. I see you ${firstRes} and you ${secondRes}. Coming up!`); 

    reader.close(); 
}    




// function scheduleGreatMovieReminder(movie) {
//     // remind in one min
//     window.setTimeout(function () {
//         console.log(`Remember to watch: ${movie}`);
//     }, 60 * 1000);
//     console.log(`Timer set for ${movie}`);
// }

// scheduleGreatMovieReminder("Citizen Kane");
// scheduleGreatMovieReminder("Touch of Evil");
// scheduleGreatMovieReminder("The Third Man");