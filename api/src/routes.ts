import { Router } from "express";
import { ensureAuth } from "./middleware/ensureAuth";
import { AuthController } from "./routes/auth/AuthController";
import { CreateUserController } from "./routes/users/create/CreateUserController";
import { DeleteUserController } from "./routes/users/delete/DeleteUserController";
import { ListUserController } from "./routes/users/list/ListUserController";
import { UpdateUserController } from "./routes/users/update/UpdateUserController";
import { PasswordChangeController } from "./routes/password/change/PasswordChangeController";
import { PasswordResetController } from "./routes/password/reset/PasswordResetController";

const router = Router();

router.post("/auth", new AuthController().handle);

//Users
router.post("/users", new CreateUserController().handle);
router.update("/users/:id", new UpdateUserController().handle);
router.get("/users", ensureAuth, new ListUserController().handle);
router.delete("/users/:id", ensureAuth, new DeleteUserController().handle);

//Password
router.post("/password-reset", new PasswordResetController().handle);
router.put("/password-change", new PasswordChangeController().handle);

export { router };
