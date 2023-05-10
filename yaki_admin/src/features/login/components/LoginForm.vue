<template>
  <form @submit.prevent="login">
    <div class="login">
        <label for="username">{{ text }}</label>
      <input type="text" v-model="form.username" @input="onInputLogin" :placeholder="usernamePlaceholder" id="username">
    
    </div>
    <div class="password">
          <label for="password">{{ text }}</label>
      <div class="enterpassword">
        <input v-model="form.password" :type="showPassword ? 'text' : 'password'" :placeholder="passwordPlaceholder" id="password" />
        <figure class = eye-box>
          <img class="eye" src="../../../assets/eye.png" @click.prevent="togglePasswordVisibility">
        </figure>
      </div>
    </div>
    <div class="submit-button">
      <button type="submit" class="signin">Sign In</button>
    </div>
    <div class="forgotten">
      <a href="http://localhost:5173/" target="_blank" rel="noopener">Forgot password ?</a>
    </div>
    
</form>
</template>

<script>
import router from "@/router/router.ts"
export default{
  data(){
    return {
      usernamePlaceholder: 'Enter your login',
      passwordPlaceholder: 'Enter your password',
      showPassword : false,
      form:{
        username : '',
        password : '',
      }
    }
  },
  methods:{
    togglePasswordVisibility() {
      this.showPassword = !this.showPassword;
      console.log("show")
    },
    onInputLogin(e){
      this.usernameText = e.target.value
    },
    login(){
      
      this.$router.push('/captain')
      
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
div{
  .signin{
    margin: auto;
    background-color: #F5CD3D;
    color: black;
    font-size: calc(var(--size-height) / 25);
    font-weight: 600;
    text-transform: uppercase;
    box-shadow: 0 5px 0 0 rgba(0, 0, 0, 0.2);
    padding: 10px 50px;
  }
  .submit-button{
    margin: auto;
    padding-top: 10px;
  }
  
}
label{
  display: block;
  font-size: 1.5rem;
  font-weight: bold;
  margin-bottom: 1rem;
}
input {
    width: 95%;
    padding: 0.5rem;
    font-size: 1.2rem;
    border-radius: 0.25rem;
    border: 1px solid #ccc;
}
form{
  margin: auto;
  width: 30%;
  display: flex;
  flex: 6;
  flex-direction: column;
}
.login {
  padding-top: calc(100vh / 15);
}
.password {
  padding-top: 10px;
}
.enterpassword {
  position: relative;
}
.enterpassword figure {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  width: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.forgotten{
  margin: auto;
  color: #0b57d0;
  font-size: 1rem;
  letter-spacing: 0.005rem;
  line-height: 1.5rem;
  font-family: 'Helvetica Neue', Helvetica, sans-serif;
}
.eye{
  margin-top: 30%;
  margin-bottom: 30%;
}


</style>