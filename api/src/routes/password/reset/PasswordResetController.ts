import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { PasswordResetService } from './PasswordResetService';

export class PasswordResetController {
  async handle(req: Request, res: Response) {
    const { phone } = req.body;
    const service = new PasswordResetService();

    try {
      const result = await service.execute(phone);

      return handleResult(res, result);
    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}