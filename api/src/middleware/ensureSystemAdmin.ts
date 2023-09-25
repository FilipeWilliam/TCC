import { UserTypes } from "@/enums";
import { Request, Response, NextFunction } from "express";

export function ensureSystemAdmin(req: Request, res: Response, next: NextFunction) {
  if (req.currentUser.type !== UserTypes.Admin) {
    return res.status(403).json({
      error: 'Tipo de usuário sem permissão.'
    });
  }

  return next();
}