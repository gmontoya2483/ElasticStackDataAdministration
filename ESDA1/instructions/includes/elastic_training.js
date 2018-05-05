function showAnswer(id) {
    var question = document.getElementById("question"+id);
    var solution = document.getElementById("answer"+id);
    solution.style.display = "block";
    question.onclick = function() { hideAnswer(id) };
    var value = question.dataset.value || "answer";
    question.value = "Hide " + value + ":";
}

function hideAnswer(id) {
    var question = document.getElementById("question"+id);
    var solution = document.getElementById("answer"+id);
    solution.style.display = "none";
    question.onclick = function() { showAnswer(id) };
    var value = question.dataset.value || "answer";
    question.value = "Show " + value + ":";
}

function build_solutions() {
    var solutions = document.getElementsByClassName("solution");
    for (var i = 0; i < solutions.length; i++) {
        solution = solutions[i];
        solution.id = "solution" + i;
        var text = solution.innerHTML;
        solution.innerHTML = "";
        
        // create question input
        var question = document.createElement("input");
        question.id = "question" + i;
        question.onclick = (function(id) { //avoid closure
            return function() { showAnswer(id) }
        })(i);
        var value = solution.dataset.value || "answer";
        question.value = "Show " + value + ":";
        question.type = "button";
        solution.appendChild(question);
      
        // create answer div
        var answer = document.createElement("div");
        answer.id = "answer" + i;
        answer.innerHTML = text;
        answer.style.display = "none";
        solution.appendChild(answer)
    }
}