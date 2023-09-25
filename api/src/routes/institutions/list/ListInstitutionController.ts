import { Response, Request } from 'express';
import { handleErrorDefault, handleResult } from '../../../utils';
import { ListInstitutionService } from './ListInstitutionService';

export class ListUserController {
  async handle(req: Request, res: Response) {
    const service = new ListInstitutionService();

    try {
      const result = await service.execute();
      return handleResult(res, result);

    } catch (err) {
      return handleErrorDefault(res, err);
    }
  }
}