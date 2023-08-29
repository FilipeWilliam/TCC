import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { PasswordChangeService } from '../change/PasswordChangeService';

export class PasswordChangeController {
  async handle(req: Request, res: Response) {
    const { id, password } = req.body;
    const service = new PasswordChangeService();

    try {
      const result = await service.execute(+id, password);

      return handleResult(res, result);
    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}