import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { CreateInstitutionService } from './CreateInstitutionService';

export class CreateInstitutionController {
  async handle(req: Request, res: Response) {
    const { name, user } = req.body;
    const service = new CreateInstitutionService();

    try {
      const result = await service.execute(name, user.name, user.email);

      return handleResult(res, result);

    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}