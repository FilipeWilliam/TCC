<template>
  <div class="login-wrapper">
    <v-card class="login-card" color="primary">
      <v-card-title class="d-flex justify-center py-3">
        <v-img src="@/assets/logo.png" max-width="120px" contain></v-img>
      </v-card-title>

      <v-card-text>
        <template v-if="formMode === 'passwordReset'">
          <v-card-text class="pt-0">Por favor, informe o seu email cadastrado na plataforma para redefinição da
            senha.</v-card-text>

          <v-form @submit.prevent="submitPasswordReset">
            <v-text-field v-model="formPasswordReset.phone" variant="outlined" label="Telefone"></v-text-field>

            <div class="py-2">
              <a @click.prevent="formMode = 'login'">Voltar</a>
            </div>

            <v-btn :loading="isLoading" block color="primary" class="mt-2" type="submit">Enviar</v-btn>
          </v-form>
        </template>

        <template v-else>
          <v-form @submit.prevent="submit">
            <v-text-field v-model="form.email" variant="outlined" label="Email"></v-text-field>

            <v-text-field v-model="form.password" variant="outlined" label="Senha" type="password"></v-text-field>

            <div class="py-2">
              <a @click.prevent="formMode = 'passwordReset'">Esqueceu sua senha?</a>
            </div>

            <v-btn :loading="isLoading" block color="secondary" class="mt-2" type="submit">Entrar</v-btn>
          </v-form>
        </template>

      </v-card-text>
    </v-card>
  </div>
</template>

<script lang="ts">
import { useAppStore } from "@/store/app";
import { catchErrorDefault, cloneDeep, handleAPISuccess } from "@/utils";
import { defineComponent, ref } from "vue";
import { useRouter } from "vue-router";

export default defineComponent({
  setup() {
    const appStore = useAppStore();
    const router = useRouter();

    //Variables
    const formMode = ref('login');
    const isLoading = ref(false);
    const form = ref({
      email: null,
      password: null
    });
    const formPasswordReset = ref({
      phone: null
    });

    const submit = () => {
      isLoading.value = true;
      appStore.signIn(form.value)
        .then((response: any) => {
          window.localStorage.setItem('apiToken', response.token);
          window.localStorage.setItem('appUser', JSON.stringify(response.data));
          router.push('/');
        })
        .catch(catchErrorDefault)
        .finally(() => isLoading.value = false);
    };

    const submitPasswordReset = () => {
      isLoading.value = true;
      let entity = cloneDeep(formPasswordReset.value);

      if (![null, ''].includes(entity.phone)) {
        entity.phone = (entity.phone as any).replace(/\D/g, '');
      }

      appStore.passwordReset(entity)
        .then((response: any) => {
          formPasswordReset.value.phone = null;
          handleAPISuccess(response, 'Foi enviado uma mensagem para redefinição da senha.');
          formMode.value = 'login';
        })
        .catch(catchErrorDefault)
        .finally(() => isLoading.value = false);
    }

    return {
      form,
      formPasswordReset,
      formMode,
      isLoading,
      submit,
      submitPasswordReset
    }
  },
});
</script>

<style>
.login-wrapper {
  background-color: var(--secondary-color);
  height: 100%;
  padding: 1.5rem;
  display: flex;
  justify-content: center;
  align-items: center;
}

.login-card {
  width: 28rem;
  padding: 0.9375rem 0.875rem;
}

.font-xl {
  font-family: "Roboto", sans-serif;
  font-size: 24px;
  font-weight: 600;
  color: rgba(0, 0, 0, 0.87);
}

.login-card a {
  color: var(--secondary-color);
  cursor: pointer;
  text-decoration: underline;
}
</style>
