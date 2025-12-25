<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #b7e1d8, #d9f1ec);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card-box {
            width: 380px;
            background: rgba(255,255,255,0.75);
            padding: 40px;
            border-radius: 18px;
            text-align: center;
        }
        .btn-submit {
            width: 100%;
            background: #0A7866;
            color: white;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            margin-top: 15px;
        }
        #timer-box {
            font-weight: bold;
            color: #d9534f;
            margin-bottom: 10px;
            font-size: 1.1rem;
        }
    </style>
</head>
<body>

<div class="card-box">
    <h3 class="text-success">Verify OTP</h3>
    <p class="text-muted">Please check your email for OTP</p>

    <div id="timer-box">
        Time Remaining: <span id="timer">02:00</span>
    </div>

    <p style="color: red">${msg}</p>

    <form action="/verifyOtp" method="post" id="otpForm">
        <input type="hidden" name="email" value="${email}" />
        <input type="text" name="otp" id="otpInput" class="form-control" placeholder="Enter OTP" required>
        <button type="submit" id="submitBtn" class="btn-submit">Verify OTP</button>
    </form>

    <div id="resend-container" style="display:none; margin-top:15px;">
        <a href="/forgotPwd" class="btn btn-link">
            <button type="button" class="btn btn-link">Go Back / Request New OTP</button>
        </a>
    </div>
</div>

<script>
    let timerInterval;

    function startTimer(duration, display) {
        let timer = duration;

        timerInterval = setInterval(function () {
            if (timer <= 0) {
                clearInterval(timerInterval);
                document.getElementById('otpInput').disabled = true;
                document.getElementById('submitBtn').disabled = true;
                document.getElementById('timer-box').innerHTML =
                    "<span class='text-danger'>OTP Expired!</span>";
                document.getElementById('resend-container').style.display = 'block';
                sessionStorage.removeItem('otpExpiry');
                return;
            }

            let minutes = parseInt(timer / 60, 10);
            let seconds = parseInt(timer % 60, 10);
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;
            display.textContent = minutes + ":" + seconds;
            timer--;
        }, 1000);
    }

    window.onload = function() {
        const display = document.querySelector('#timer');
        const now = Date.now();

        // Check if an expiry exists in sessionStorage
        let expiry = sessionStorage.getItem('otpExpiry');

        if (!expiry || now >= expiry) {
            // First load or previous OTP expired → set new expiry 2 minutes from now
            expiry = now + 2 * 60 * 1000;
            sessionStorage.setItem('otpExpiry', expiry);
        }

        // Calculate remaining time in seconds
        let remainingTime = Math.floor((expiry - now) / 1000);
        if (remainingTime < 0) remainingTime = 0;

        startTimer(remainingTime, display);
    };

    document.getElementById('otpForm').addEventListener('submit', function() {
        // Clear timer and sessionStorage on form submit (success or wrong OTP)
        clearInterval(timerInterval);
        sessionStorage.removeItem('otpExpiry');
    });
</script>

</body>
</html>
