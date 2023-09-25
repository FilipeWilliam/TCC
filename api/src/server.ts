import { serverHttp } from "./app";
import {verifyNeedDBInit} from "./routines";

serverHttp.listen(process.env.PORT || 3000, () => {
  console.log("Server is running!");
  verifyNeedDBInit();
});
