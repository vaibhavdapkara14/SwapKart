<!-- reset-password.jsp -->
<div class="login-card p-5">
    <h3>Set New Password</h3>
    <form action="resetPassword" method="post">
        <input type="hidden" name="token" value="${token}">
        <input type="password" name="password" class="form-control mb-3" placeholder="Enter New Password" required>
        <button class="btn btn-success w-100">Update Password</button>
    </form>
</div>