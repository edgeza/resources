// Deobfuscated version of the exam logic with bug fixes
let Question = {};

// Event listener for exam start
addEventListener('message', async function(event) {
    var data = event.data;
    console.log('Received message:', data); // Debug all messages
    
    if (data.type == 'StartExam') {
        Question = data.data;
        console.log('Received exam data:', Question); // Debug log
        console.log('Question title:', Question?.title); // Debug specific field
        console.log('Question description:', Question?.description); // Debug specific field
        console.log('Question Questions:', Question?.Questions); // Debug specific field
        
        // If no data is received, use default exam configuration
        if (!Question || !Question.title) {
            console.log('No exam data received, using default configuration');
            Question = {
                title: 'Bar Exam',
                description: 'Complete this test to get your Bar License, you need this in order to practise law.',
                Logo: 'https://www.policeinspire.co.uk/wp-content/uploads/2020/11/online-study-platform-vector.svg',
                Minimum: 6,
                AmountOfQuestionsToShow: 6,
                ShuffleQuestions: true,
                Questions: {
                    1: { 
                        question: 'What should happen if a suspect requests a public defender but no lawyers are online?', 
                        correctAnswer: 'b', 
                        answers: {
                            a: 'Let the arresting officer continue without informing anyone', 
                            b: 'Proceed with a default "not guilty" plea and document that no representation was available', 
                            c: 'Delay the process until a DOJ response is received or 5 minutes have passed', 
                            d: 'The officer should act as the lawyer temporarily' 
                        }
                    },
                    2: { 
                        question: 'Can a DOJ official serve as both prosecutor and defense attorney in the same case? Why?', 
                        correctAnswer: 'b', 
                        answers: {
                            a: 'Yes, if they are the only DOJ staff online', 
                            b: 'No, it causes a conflict of interest', 
                            c: 'Only if both sides agree', 
                            d: 'No, it violates DOJ integrity standards' 
                        }
                    },
                    3: { 
                        question: 'A police officer introduces evidence mid-trial. What\'s the correct response from the defense attorney?', 
                        correctAnswer: 'b', 
                        answers: {
                            a: 'Accept it if it helps your case', 
                            b: 'Object due to late disclosure', 
                            c: 'File motion to exclude', 
                            d: 'Request trial be paused and restarted' 
                        }
                    },
                    4: { 
                        question: 'Can a judge overrule a jury verdict in your DOJ system?', 
                        correctAnswer: 'c', 
                        answers: {
                            a: 'No, jury verdicts are final', 
                            b: 'Yes, if the defendant is clearly guilty', 
                            c: 'Yes, in case of jury tampering or misconduct', 
                            d: 'No, unless there\'s a post-trial review process' 
                        }
                    },
                    5: { 
                        question: 'Who may approve a search warrant if a judge is unavailable?', 
                        correctAnswer: 'b', 
                        answers: {
                            a: 'Any law enforcement officer above the rank of sergeant', 
                            b: 'Assistant Attorney General', 
                            c: 'On-duty DOJ Supervisor', 
                            d: 'Defense Attorney' 
                        }
                    },
                    6: { 
                        question: 'A person breaks into a convenience store with a crowbar after it is closed, intending to steal money from the cash register. However, the register is empty. What is the most appropriate charge?', 
                        correctAnswer: 'c', 
                        answers: {
                            a: 'Theft/Larceny', 
                            b: 'Vandalism', 
                            c: 'Burglary', 
                            d: 'No crime was committed' 
                        }
                    }
                }
            };
        }
        
        // Reset score and question index when starting a new exam
        currentQuestionIndex = 0;
        score = 0;
        selectedQuestions = [];
        document.getElementById('UI').classList.remove('hidden');
        initializeStartExam();
    }
});

// DOM elements
const startExamTitle = document.getElementById('StartExamTitle');
const startExamDescription = document.getElementById('StartExamDescription');
const startExamLogo = document.getElementById('StartExamLogo');
const questionText = document.getElementById('Question');
const questionNumber = document.getElementById('QuestionNumber');
const answers = [
    document.getElementById('A1'),
    document.getElementById('A2'),
    document.getElementById('A3'),
    document.getElementById('A4')
];
const startExamButton = document.getElementById('StartExamButtonStart');
const cancelExamButton = document.getElementById('StartExamButtonCancel');
const finishExamScreen = document.getElementById('FinishExam');
const finishExamScore = document.getElementById('FinishExamCorrectAnswers');
const finishExamButton = document.getElementById('FinishExamButton');
const startExamScreen = document.getElementById('StartExam');
const questionsScreen = document.getElementById('Questions');

// Global variables
let currentQuestionIndex = 0;
let score = 0;
let selectedQuestions = [];

function initializeStartExam() {
    console.log('Initializing exam with data:', Question); // Debug log
    
    // Add error handling for missing data
    if (!Question || !Question.title) {
        console.error('Exam data is missing or invalid:', Question);
        // Set default values if data is missing
        startExamTitle.textContent = 'Bar Exam';
        startExamDescription.textContent = 'Complete this test to get your Bar License.';
        return;
    }
    
    startExamTitle.textContent = Question.title || 'Bar Exam';
    startExamDescription.textContent = Question.description || 'Complete this test to get your Bar License.';
    startExamLogo.innerHTML = '';
    
    if (Question.Logo) {
        const img = document.createElement('img');
        img.src = Question.Logo;
        img.alt = 'Exam Logo';
        img.classList.add('w-full', 'h-full', 'object-contain');
        startExamLogo.appendChild(img);
    }
    
    selectQuestions();
}

function selectQuestions() {
    // Add error handling for missing questions
    if (!Question.Questions) {
        console.error('No questions found in exam data');
        return;
    }
    
    const questionKeys = Object.keys(Question.Questions);
    console.log('Available question keys:', questionKeys); // Debug log
    
    // Shuffle questions if enabled
    if (Question.ShuffleQuestions) {
        questionKeys.sort(() => Math.random() - 0.5);
    }
    
    selectedQuestions = questionKeys.slice(0, Question.AmountOfQuestionsToShow || 6);
    console.log('Selected questions:', selectedQuestions); // Debug log
}

// Start exam button event
startExamButton.addEventListener('click', () => {
    startExamScreen.classList.add('hidden');
    questionsScreen.classList.remove('hidden');
    currentQuestionIndex = 0;
    score = 0; // Reset score when starting exam
    renderQuestion();
});

// Cancel exam button event
cancelExamButton.addEventListener('click', () => {
    location.reload();
    currentQuestionIndex = 0;
    score = 0;
    selectedQuestions = [];
    Question = {};
    $.post('https://ap-questionnaire/CloseUI');
});

function renderQuestion() {
    if (currentQuestionIndex >= selectedQuestions.length) {
        finishExam();
        return;
    }
    
    const questionKey = selectedQuestions[currentQuestionIndex];
    const questionData = Question.Questions[questionKey];
    
    console.log('Rendering question:', questionKey, questionData); // Debug log
    
    if (!questionData) {
        console.error('Question data is missing for key:', questionKey);
        return;
    }
    
    questionNumber.textContent = 'Question ' + (currentQuestionIndex + 1);
    questionText.textContent = questionData.question || questionData.Question || 'Question not found';
    
    const answerKeys = Object.keys(questionData.answers || questionData);
    console.log('Answer keys:', answerKeys); // Debug log
    
    answers.forEach((answer, index) => {
        const answerKey = answerKeys[index];
        if (answerKey && answerKey !== 'question' && answerKey !== 'Question' && answerKey !== 'correctAnswer' && answerKey !== 'Answer') {
            answer.textContent = questionData.answers ? questionData.answers[answerKey] : questionData[answerKey];
            answer.onclick = () => handleAnswer(answerKey);
        }
    });
}

function handleAnswer(answerKey) {
    const questionKey = selectedQuestions[currentQuestionIndex];
    const questionData = Question.Questions[questionKey];
    
    if (!questionData) {
        console.error('Question data is missing for key:', questionKey);
        currentQuestionIndex++;
        renderQuestion();
        return;
    }
    
    // Check if the answer is correct (support both old and new format)
    const correctAnswer = questionData.correctAnswer || questionData.Answer;
    console.log('Checking answer:', answerKey, 'against correct answer:', correctAnswer); // Debug log
    
    if (answerKey === correctAnswer) {
        score++;
        console.log('Correct answer! Score:', score); // Debug log
    }
    
    currentQuestionIndex++;
    renderQuestion();
}

function finishExam() {
    questionsScreen.classList.add('hidden');
    finishExamScreen.classList.remove('hidden');
    
    finishExamScore.textContent = 'You got ' + score + ' out of ' + (Question.AmountOfQuestionsToShow || 6) + ' correct!';
    
    const minimumScore = Question.Minimum || 6;
    const passFailText = score >= minimumScore ? 
        'Congratulations! You passed the exam!' : 
        'Unfortunately, you failed the exam. Please try again.';
    
    document.getElementById('FinishExamPassOrFail').textContent = passFailText;
    
    // Set logo if available
    const finishExamLogo = document.getElementById('FinishExamLogo');
    if (Question.Logo) {
        finishExamLogo.innerHTML = '';
        const img = document.createElement('img');
        img.src = Question.Logo;
        img.alt = 'Exam Logo';
        img.classList.add('w-full', 'h-full', 'object-contain');
        finishExamLogo.appendChild(img);
    }
    
    const passed = score >= minimumScore;
    $.post('https://ap-questionnaire/ExamResult', JSON.stringify({'passed': passed}));
}

// Finish exam button event
finishExamButton.addEventListener('click', () => {
    location.reload();
    currentQuestionIndex = 0;
    score = 0;
    selectedQuestions = [];
    Question = {};
    $.post('https://ap-questionnaire/CloseUI');
});