import { Request, Response, NextFunction } from "express";
import { verify } from 'jsonwebtoken';

export function ensureAuth(req: Request, res: Response, next: NextFunction) {
  const authToken = req.headers.authorization;

  if (!authToken) {
    return res.status(401).json({
      error: 'Token inválido.'
    });
  }

  const [, token] = authToken.split(' ');

  try {
    const { user } = verify(token, process.env.JWT_SECRET);
    req.currentUser = user;
    return next();

  } catch (error) {
    return res.status(401).json({
      error: 'Token expirado.'
    });
  }
}