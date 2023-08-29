import express from "express";
import http from "http";
import cors from "cors";
import { router } from "./routes";

const app = express();
app.use(cors());

const serverHttp = http.createServer(app);

app.use(express.json({ limit: "17mb" }));
app.use(express.urlencoded({ limit: "17mb" }));
app.use(router);

export { serverHttp };
