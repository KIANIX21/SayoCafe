<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="SayoCafe.login" %>

<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <link rel="icon" href="img/Logo Rumahku Istanaku.png" type="image/x-icon">
  <link rel="stylesheet" href="../css/login.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
</head>
<body>
  <div class="container">
    <div class="wrapper">
      <div class="title"><span>Login Admin</span></div>
      <form runat="server" method="post" onsubmit="return validateLogin()">
        <div class="row">
          <i class="fas fa-user"></i>
          <asp:TextBox ID="txtname" runat="server" placeholder="username" ></asp:TextBox>
        </div>
        <div class="row">
          <i class="fas fa-lock"></i>
          <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" ></asp:TextBox>
        </div>
        <div class="row button">
          <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
        </div>
      </form>
    </div>
  </div>
</body>
</html>
