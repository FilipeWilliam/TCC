import { serverHttp } from "./app";
import {
  initScheduler,
  verifyNeedDBInit,
  createUsersBotConversa,
} from "./routines";

serverHttp.listen(process.env.PORT || 3000, () => {
  console.log("Server is running!");

  verifyNeedDBInit();

  if (process.env.ENVIRONMENT === "PRODUCTION") {
    createUsersBotConversa();
    initScheduler();
  }
});
